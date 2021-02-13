use super::GitHub;

pub struct CreatePullRequestArguments {
    pub owner: String,
    pub repo: String,
    pub title: String,
    pub body: String,
    pub head: String,
    pub base: String,
}

impl GitHub {
    pub async fn create_pull_request(&self, args: CreatePullRequestArguments) -> octocrab::Result<octocrab::models::pulls::PullRequest, octocrab::Error> {
        self.client.pulls(args.owner, args.repo).create(args.title, args.head, args.base).body(args.body).send().await
    }
}

