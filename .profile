# .profile 
SVN_ROOT=https://simatra.jira.com/svn
export SVN_DYNAMO=${SVN_ROOT}/DYNAMO
export SVN_SIMENGINE=${SVN_ROOT}/SIMENGINE
export SVN_WEB=${SVN_ROOT}/WEB
export SVN_BUILD=${SVN_ROOT}/BUILD
export SVN_PUBS=${SVN_ROOT}/PUBLICATIONS

if [ -d /usr/local/cuda ]
then
    PATH=/usr/local/cuda/bin:${PATH}
    MANPATH=/usr/local/cuda/bin:${MANPATH}
    LD_LIBRARY_PATH=/usr/local/cuda/lib:${LD_LIBRARY_PATH}
    DYLD_LIBRARY_PATH=/usr/local/cuda/lib:${DYLD_LIBRARY_PATH}
    export DYLD_LIBRARY_PATH
fi

if [ -d /Applications/Emacs.app ]
then
    PATH=/Applications/Emacs.app/Contents/MacOS/bin:${PATH}
    EDITOR=emacsclient
fi

# if [ -d /Applications/MATLAB_R2010a.app/toolbox/Simatra ]
# then
#     export SIMENGINE=/Applications/MATLAB_R2010a.app/toolbox/Simatra
# fi

export PATH
export EDITOR
