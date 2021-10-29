{ config, pkgs, lib, ... }:

let cfg = config.programs.eliza.git;
in with lib; {
  options = {
    programs.eliza.git = {
      enable = mkEnableOption "custom git configs";
      user = {
        name = mkOption {
          type = with types; uniq string;
          description = "Git user name";
        };
        email = mkOption {
          type = with types; uniq string;
          description = "Git user email";
        };
        privateConfig = mkOption {
          type = with types; uniq path;
          default = ./git.private.nix;
          description = "path to private local config";
          example = ./git.config.nix;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs = {
      # GitHub CLI tool
      gh = {
        enable = true;
        settings = {
          # use ssh whenever possible
          git_protocol = "ssh";
          aliases = {
            co = "pr checkout";
            pv = "pr view";
          };
        };

      };

      git = {
        enable = true;
        userName = cfg.user.name;
        userEmail = cfg.user.email;

        # aliases
        aliases = {
          ### short aliases for common commands ###
          co = "checkout";
          ci = "commit";
          rb = "rebase";
          rbct = "rebase --continue";
          please = "push --force-with-lease";
          commend = "commit --amend --no-edit";

          ### nicer commit and branch verbs ###
          squash = "merge --squash";
          # Get the current branch name (not so useful in itself, but used in
          # other aliases)
          branch-name = "!git rev-parse --abbrev-ref HEAD";
          # Push the current branch to the remote "origin", and set it to track
          # the upstream branch
          publish = "!git push -u origin $(git branch-name)";
          # Delete the remote version of the current branch
          unpublish = "!git push origin :$(git branch-name)";
          # sign the last commit
          sign = "commit --amend --reuse-message=HEAD -sS";
          uncommit = "reset --hard HEAD";
          # XXX(eliza) AGH THIS DOESNT WORK
          # # Gets the parent of the current branch.
          # parent = ''
          #   show-branch -a \
          #     | grep '\*' \
          #     | grep -v `git rev-parse --abbrev-ref HEAD` \
          #     | head -n1 \
          #     | sed 's/.*\[\(.*\)\].*/\1/' \
          #     | sed 's/[\^~].*//'
          # '';

          ### various git log aliases ###
          ls = ''
            log --pretty=format:"%C(yellow)%h%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate'';
          ll = ''
            log --pretty=format:"%C(yellow)%h%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate --numstat'';
          lt = "log --graph --oneline --decorate --all";
          summarize-branch = ''
            log --pretty=format:"* %h %s%n%n%w(72,2,2)%b" --decorate
          '';
          lol = "log --graph --decorate --pretty=oneline --abbrev-commit";
          lola =
            "log --graph --decorate --pretty=oneline --abbrev-commit --all";

          ### status ###
          st = "status --short --branch";
          stu = "status -uno";

          pr =
            "!pr() { git fetch origin pull/$1/head:pr-$1; git checkout pr-$1; }; pr";
        };

        # extra git config
        extraConfig = {
          # use rebase in `git pull` to avoid gross merge commits.
          pull.rebase = true;
          # when fetching, prune unreachable objects in the local repository.
          fetch.prune = true;
          # differentiate between moved and added lines in diffs
          diff.colorMoved = "zebra";
          # Assembly-style commit message comments (`;` as the comment delimiter).
          # Why use `;`?
          # - The default character, `#`, conflicts with both Markdown headings
          #   and with GitHub issue links beginning a line (which I need to be
          #   able to use in commit messages).
          # - `*` conflicts with Markdown lists
          # - Git only supports a single character comment delimiter, so C-style
          #   line comments (`//`) are out...
          # - I can't think of any compelling reason to begin a line with `;`...
          core.commentchar = ";";
        };
        # If there is a file called `.git.private.nix` that defines an attribute
        # "key", sign commits with that key.
        signing = let
          path = cfg.user.privateConfig;
          exists = with builtins;
            (traceIf false
              "warning: git private config path ${path} does not exist"
              (pathExists path));
        in if exists then {
          key = with import path; key;
          signByDefault = true;
        } else
          { };
      };
    };
  };
}
