#!/bin/bash

echo "Launching pwndocker"

cat > /tmp/.pwnDockerBashAliases << :EOF
gropper () { ropper -f "\$1" --nocolor | grep "\$2"; }
alias aslr="setarch \`uname -m\` -R"
export PS1="\n--------------------\n\w \T \$?\n\\\\$ \[\$(tput sgr0)\]"
:EOF

pwnDockerSuffix="@sha256:7a91fcee7f34679a40bef80f82a2872298530b0c78c2e0ac9fd183c15fe60ba2"

if [ "$(uname)" == "Darwin" ]; then
  # Mac support
  docker run -d --rm -h banana --name banana -v /tmp/.pwnDockerBashAliases:/root/.bash_aliases  -v $(pwd):/ctf/work -p 23946:23946 --cap-add=SYS_PTRACE --security-opt seccomp=unconfined skysider/pwndocker$pwnDockerSuffix >/dev/null 2>&1
  docker exec -it banana /bin/bash
else
  if ! id -nG | grep -qw docker; then
      echo Current user not part of the docker group!
      echo Please run: \`usermod $(whoami) -aG docker\`
      echo Then restart your shell
      exit
  fi

  sg docker 'cd $(pwd); docker run -d --rm -h banana --name banana -v /tmp/.pwnDockerBashAliases:/root/.bash_aliases  -v $(pwd):/ctf/work -p 23946:23946 --cap-add=SYS_PTRACE --security-opt seccomp=unconfined skysider/pwndocker$pwnDockerSuffix >/dev/null 2>&1'
  sg docker 'docker exec -it banana /bin/bash'
fi
