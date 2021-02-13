VERSION = $(patsubst "%",%, $(word 3, $(shell grep version Cargo.toml)))
BIN_NAME = ghana

install-binary:
	curl -sL https://github.com/konojunya/ghana.vim/releases/download/v${VERSION}/ghana-v${VERSION}-x86_64-mac.zip -o ghana.zip
	unzip ghana.zip

release:
	git tag v${VERSION}
	git push origin v${VERSION}

# release_lnx:
# 	cargo build --locke --release --target=x86_64-unknown-linux-musl
# 	zip -j ${BIN_NAME}-v${VERSION}-x86_64-lnx.zip target/x86_64-unknown-linux-musl/release/${BIN_NAME}
#
# release_win:
# 	cargo build --locked --release --target=x86_64-pc-windows-msvc
# 	7z a ${BIN_NAME}-v${VERSION}-x86_64-win.zip target/x86_64-pc-windows-msvc/release/${BIN_NAME}.exe

release_mac:
	cargo build --release --target=x86_64-apple-darwin
	zip -j ${BIN_NAME}-v${VERSION}-x86_64-mac.zip target/x86_64-apple-darwin/release/${BIN_NAME}
