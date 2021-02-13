use crate::event::EventHandler;

pub trait Issue {
    fn list_issue(&mut self);
}

impl Issue for EventHandler {
    fn list_issue(&mut self) {
        print!("Hello");
    }
}
