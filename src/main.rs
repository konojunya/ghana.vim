mod event;
mod github;

use event::EventHandler;

fn main() {
    let mut event_handler = EventHandler::new();
    event_handler.recv();
}
