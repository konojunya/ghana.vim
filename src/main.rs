mod event;
mod github;

#[tokio::main]
async fn main() {
    event::run().await;
}
