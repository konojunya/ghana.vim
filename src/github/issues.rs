use super::GitHub;
use octocrab::{models, params};

pub struct ListIssueArguments {
    pub owner: String,
    pub repo: String,
}

impl GitHub {
    pub async fn list_issue(
        &self,
        args: ListIssueArguments
    ) -> std::result::Result<octocrab::Page<models::issues::Issue>, octocrab::Error> {
        self.client
            .issues(args.owner, args.repo)
            .list()
            .state(params::State::Open)
            .per_page(50)
            .send()
            .await
    }
}
