# .profile

if [ -d /usr/local/cuda ]
then
    PATH=/usr/local/cuda/bin:${PATH}
    MANPATH=/usr/local/cuda/bin:${MANPATH}
    LD_LIBRARY_PATH=/usr/local/cuda/lib:${LD_LIBRARY_PATH}
    DYLD_LIBRARY_PATH=/usr/local/cuda/lib:${DYLD_LIBRARY_PATH}
fi

if [ -d /Applications/Emacs.app ]
then
    PATH=/Applications/Emacs.app/Contents/MacOS/bin:${PATH}
    EDITOR=emacsclient
fi

if [ -d /usr/local/mysql ]
then
    PATH=/usr/local/mysql/bin:${PATH}
    MANPATH=/usr/local/mysql/bin:${MANPATH}
    LD_LIBRARY_PATH=/usr/local/mysql/lib:${LD_LIBRARY_PATH}
    DYLD_LIBRARY_PATH=/usr/local/mysql/lib:${DYLD_LIBRARY_PATH}
fi

if [ -s ~/.rvm/scripts/rvm ]
then
    . ~/.rvm/scripts/rvm
fi

if [ -z "${SSH_AUTH_SOCK}" ]; then
    eval $(ssh-agent)
    trap 'eval $(ssh-agent -k)' EXIT HUP
fi

export EC2_HOME=~/.ec2
export EC2_PRIVATE_KEY=${EC2_HOME}/pk-ZKOBFHLKXZOKA6MHE3CHOW4VUE57RCEH.pem
export EC2_CERT=${EC2_HOME}/cert-ZKOBFHLKXZOKA6MHE3CHOW4VUE57RCEH.pem

export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home

if [ -d ${EC2_HOME} ]
then
    PATH=${EC2_HOME}/bin:${PATH}
fi

export PATH
export EDITOR
export LD_LIBRARY_PATH
export DYLD_LIBRARY_PATH
