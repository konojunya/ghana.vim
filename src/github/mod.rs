use octocrab::Octocrab;

pub mod issues;
pub mod pulls;

pub struct GitHub {
    client: Octocrab,
}

impl GitHub {
    pub fn new(token: String) -> GitHub {
        match Octocrab::builder().personal_token(token).build() {
            Ok(client) => GitHub { client },
            Err(e) => panic!(e),
        }
    }

    pub fn read_token_env() -> String {
        std::env::var("GHANA_GITHUB_TOKEN").expect("GHANA_GITHUB_TOKEN env variable is required.")
    }
}
