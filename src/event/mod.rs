use crate::event::issue::Issue;
use crate::github::GitHub;
use neovim_lib::{Neovim, NeovimApi, Session};

mod issue;

enum Messages {
    // issue
    ListIssue,
    // pulls
    CreatePullRequest,
    Unknown(String),
}

impl From<String> for Messages {
    fn from(event: String) -> Self {
        match &event[..] {
            "list_issue" => Messages::ListIssue,
            "create_pull_request" => Messages::CreatePullRequest,
            _ => Messages::Unknown(event),
        }
    }
}

pub struct EventHandler {
    nvim: Neovim,
    client: GitHub,
}

impl EventHandler {
    pub fn new() -> EventHandler {
        let session = Session::new_parent().unwrap();
        let nvim = Neovim::new(session);
        let token = std::env::var("GHANA_GITHUB_TOKEN")
            .expect("GHANA_GITHUB_TOKEN env variable is required.");
        let client = GitHub::new(token);

        EventHandler { nvim, client }
    }

    pub fn recv(&mut self) {
        let receiver = self.nvim.session.start_event_loop_channel();

        for (event, values) in receiver {
            match Messages::from(event) {
                // issue
                Messages::ListIssue => {
                    self.list_issue();
                    self.nvim
                        .command(&format!("call ghana#rpc#hoge({:?})", values))
                        .unwrap();
                }

                // pulls
                Messages::CreatePullRequest => {
                    // call github.create_pull_request
                    self.nvim
                        .command(&format!("echo \"call pull request: {:?}\"", values))
                        .unwrap();
                }
                Messages::Unknown(event) => {
                    self.nvim
                        .command(&format!("echo \"Unknown command: {}\"", event))
                        .unwrap();
                }
            }
        }
    }
}
