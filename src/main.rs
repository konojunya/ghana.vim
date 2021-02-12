mod github;
mod nvim;

use nvim::EventHandler;

fn main() {
    let mut event_handler = EventHandler::new();
    event_handler.recv();
}
