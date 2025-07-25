set +e
has_git="$(command -v git)"
has_cargo="$(command -v ~/.cargo/bin/cargo)"
has_sudo="$(command -v sudo)"
has_grep="$(command -v grep)"
has_youtubedl="$(command -v youtube-dl)"
has_pip3="$(command -v pip3)"
set -e
set -x


if ! ( [ -x "$has_git" ] && [ -x "$has_grep" ] && [ -f "/usr/lib/i386-linux-gnu/libssl.so" ] ); then
	echo "Installing apt dependencies..."
	if ! [ -x "$has_sudo" ]; then
		dpkg --add-architecture i386
		apt-get update
		apt-get install -y git libssl-dev:i386
		rm -rf /var/lib/apt/lists/*
	else
		sudo dpkg --add-architecture i386
		sudo apt-get update
		sudo apt-get install -y git libssl-dev:i386
		sudo rm -rf /var/lib/apt/lists/*
	fi
fi
dpkg --add-architecture i386
apt-get update
apt-get install -y lib32z1 pkg-config libssl-dev:i386 libssl-dev libssl3:i386


if ! [ -x "$has_cargo" ]; then
	echo "Installing rust..."
	curl https://sh.rustup.rs -sSf | sh -s -- -y
	. ~/.profile
fi


if ! [ -x "$has_ytdlp" ]; then
	echo "Installing yt-dlp with pip3..."
	pip3 install yt-dlp --break-system-packages
else
	echo "Ensuring yt-dlp is up-to-date with pip3..."
	pip3 install yt-dlp -U --break-system-packages
fi
