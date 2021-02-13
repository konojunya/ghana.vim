use crate::github::{GitHub, issues};

pub async fn print_list_issue(github: GitHub) {
    let args = issues::ListIssueArguments{
        owner: "konojunya".to_string(),
        repo: "ghana.vim".to_string()
    };

    match github.list_issue(args).await {
        Ok(page) => {
            for issue in page {
                println!("#{}: {}",issue.number, issue.title);
            }
        },
        Err(e) => println!("error: {}", e)
    }
}

