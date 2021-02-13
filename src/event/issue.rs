use crate::event::EventHandler;
use neovim_lib::NeovimApi;
use neovim_lib::Value;

pub trait Issue {
    fn list_issue(&mut self, values: Vec<Value>);
}

impl Issue for EventHandler {
    fn list_issue(&mut self, values: Vec<Value>) {
        self.nvim.command("new").unwrap();
        self.nvim.command("set buftype=nofile").unwrap();
        self.nvim
            .command(&format!(
                "call append(1, \"{}\")",
                values
                    .iter()
                    .map(|v| v.to_string())
                    .collect::<Vec<String>>()
                    .len()
            ))
            .unwrap();
    }
}
