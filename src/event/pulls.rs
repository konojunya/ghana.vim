use crate::github::{GitHub, pulls};

pub async fn print_create_pull_request(github: GitHub) {
    let args = pulls::CreatePullRequestArguments{
        owner: "konojunya".to_string(),
        repo: "ghana.vim".to_string(),
        title: "title".to_string(),
        body: "body".to_string(),
        head: "head".to_string(),
        base: "base".to_string(),
    };

    match github.create_pull_request(args).await {
        Ok(_) => println!("create pull request!"),
        Err(e) => println!("error: {}", e),
    }
}
