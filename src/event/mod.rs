use crate::github::GitHub;
use std::env;

mod issues;
mod pulls;

pub async fn run() {
    let token = GitHub::read_token_env();
    let github = GitHub::new(token);
    let input = env::args().collect::<Vec<String>>();

    if let Some(command) = input.get(1) {
        if command == "list_issue" {
            issues::print_list_issue(github).await;
        } else if command == "create_pull_request" {
            pulls::print_create_pull_request(github).await;
        }
    }
}
