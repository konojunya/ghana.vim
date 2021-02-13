use crate::github::GitHub;
use neovim_lib::{Neovim, NeovimApi, Session};

enum Messages {
    // pulls
    CreatePullRequest,
    Unknown(String),
}

impl From<String> for Messages {
    fn from(event: String) -> Self {
        match &event[..] {
            "create_pull_request" => Messages::CreatePullRequest,
            _ => Messages::Unknown(event),
        }
    }
}

pub struct EventHandler {
    nvim: Neovim,
    github: GitHub,
}

impl EventHandler {
    pub fn new() -> EventHandler {
        let session = Session::new_parent().unwrap();
        let nvim = Neovim::new(session);
        let token = std::env::var("GHANA_GITHUB_TOKEN")
            .expect("GHANA_GITHUB_TOKEN env variable is required.");
        let github = GitHub::new(token);

        EventHandler { nvim, github }
    }

    pub fn recv(&mut self) {
        let receiver = self.nvim.session.start_event_loop_channel();

        for (event, values) in receiver {
            match Messages::from(event) {
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
