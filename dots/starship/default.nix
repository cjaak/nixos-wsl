{pkgs, ...}: {
  programs.starship = {
    enable = true;
    settings = {
      format = "[ ](bright-white)[ ](bold fg:black bg:bright-white)[](bg:red fg:bright-white)$nodejs$python[](fg:red bg:green)$git_branch$git_status[](fg:green bg:blue)$directory[](fg:blue)$fill$time\n$character";
      aws.disabled = true;
      gcloud.disabled = true;
      kubernetes.disabled = false;
      git_branch.style = "242";
      directory.style = "blue";
      directory.truncate_to_repo = false;
      directory.truncation_length = 8;
      python.disabled = true;
      ruby.disabled = true;
      hostname.ssh_only = false;
      hostname.style = "bold green";
    };
  };
}
