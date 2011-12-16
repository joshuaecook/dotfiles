# .profile

export PATH
export EDITOR
export LD_LIBRARY_PATH
export DYLD_LIBRARY_PATH

# NB changes to this environment file are not recognized until the next time the user logs in
MACOSX_ENV="${HOME}/.MacOSX/environment"

RVM_PREFIX="${HOME}/.rvm"
# if [ -s "${RVM_PREFIX}/scripts/rvm" ]; then
#     source "${RVM_PREFIX}/scripts/rvm"
# fi

CUDA_PREFIX="/usr/local/cuda"
if [ -d "${CUDA_PREFIX}" ]; then
    PATH="${CUDA_PREFIX}/bin:${PATH}"
    MANPATH="${CUDA_PREFIX}/man:${MANPATH}"
    LD_LIBRARY_PATH="${CUDA_PREFIX}/lib:${LD_LIBRARY_PATH}"
    DYLD_LIBRARY_PATH="${CUDA_PREFIX}/lib:${DYLD_LIBRARY_PATH}"
fi

if [ -d /Applications/Emacs.app ]; then
    PATH="/Applications/Emacs.app/Contents/MacOS/bin:${PATH}"
    EDITOR=emacsclient
fi

MYSQL_PREFIX="/usr/local/mysql"
if [ -d "${MYSQL_PREFIX}" ]; then
    PATH="${MYSQL_PREFIX}/bin:${PATH}"
    MANPATH="${MYSQL_PREFIX}/man:${MANPATH}"
    LD_LIBRARY_PATH="${MYSQL_PREFIX}/lib:${LD_LIBRARY_PATH}"
    DYLD_LIBRARY_PATH="${MYSQL_PREFIX}/lib:${DYLD_LIBRARY_PATH}"
fi

if [ -d "${HOME}/.local" ]; then
    PATH="${HOME}/.local/bin:${PATH}"
fi

if [ -d "${HOME}/.rbenv" ]; then
    PATH="${HOME}/.rbenv/bin:${PATH}"
    eval $(rbenv init -)
fi

if [ -z "${SSH_AUTH_SOCK}" ]; then
    eval $(ssh-agent)
    trap 'eval $(ssh-agent -k)' EXIT HUP
fi

export EC2_HOME=~/.ec2
export EC2_KEYPAIR=joshuaecook
export EC2_PRIVATE_KEY="${EC2_HOME}/pk-ZKOBFHLKXZOKA6MHE3CHOW4VUE57RCEH.pem"
export EC2_CERT="${EC2_HOME}/cert-ZKOBFHLKXZOKA6MHE3CHOW4VUE57RCEH.pem"
defaults write "${MACOSX_ENV}" EC2_HOME "${EC2_HOME}"
defaults write "${MACOSX_ENV}" EC2_KEYPAIR "${EC2_KEYPAIR}"
defaults write "${MACOSX_ENV}" EC2_PRIVATE_KEY "${EC2_PRIVATE_KEY}"
defaults write "${MACOSX_ENV}" EC2_CERT "${EC2_CERT}"

export JAVA_HOME=/Library/Java/Home
defaults write $HOME/.MacOSX/environment JAVA_HOME "$JAVA_HOME"

if [ -d ${EC2_HOME} ]; then
    PATH="${EC2_HOME}/bin:${PATH}"
fi

defaults write "${MACOSX_ENV}" PATH "${PATH}"
defaults write "${MACOSX_ENV}" EDITOR "${EDITOR}"
defaults write "${MACOSX_ENV}" LD_LIBRARY_PATH "${LD_LIBRARY_PATH}"
defaults write "${MACOSX_ENV}" DYLD_LIBRARY_PATH "${DYLD_LIBRARY_PATH}"
