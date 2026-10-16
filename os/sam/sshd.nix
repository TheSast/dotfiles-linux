{
  config,
  lib,
  ...
}: let
  cfg = config.services.opensshServer;
in {
  options.services.opensshServer = {
    enable = lib.mkOption {
      type = lib.types.nullOr lib.types.bool;
      default = null;
      description = "Install and enable OpenSSH Server; false removes it; null leaves it alone.";
    };

    startupType = lib.mkOption {
      type = lib.types.nullOr (
        lib.types.enum [
          "automatic"
          "disabled"
          "manual"
        ]
      );
      default = null;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      # winpkgs.activation.installOpenSSHServer.command = ''
      # powershell
      #   $capability = Get-WindowsCapability -Online -Name 'OpenSSH.Server~~~~0.0.1.0'
      #   if ($capability.State -ne 'Installed') {
      #     Add-WindowsCapability -Online -Name 'OpenSSH.Server~~~~0.0.1.0' | Out-Null
      #   }
      #   Set-Service -Name sshd -StartupType Automatic
      #  '';
      winpkgs.activation.installOpenSSHServer.command =
        # powershell
        ''
          Add-WindowsCapability -Online -Name 'OpenSSH.Server~~~~0.0.1.0' | Out-Null
          Start-Service -Name sshd
          Set-Service -Name sshd -StartupType Automatic
        '';
    })
    (lib.mkIf (cfg.enable == false) {
      # TODO: remove the OpenSSH-Server-In-TCP rule if it remains.
      winpkgs.activation.removeOpenSSHServer.command =
        # powershell
        ''
          $service = Get-Service -Name sshd -ErrorAction SilentlyContinue
          if ($service) {
            if ($service.Status -ne 'Stopped') {
              Stop-Service -Name sshd -Force
            }
          }

          $capability = Get-WindowsCapability -Online -Name 'OpenSSH.Server~~~~0.0.1.0'
          if ($capability.State -eq 'Installed') {
            Remove-WindowsCapability -Online -Name 'OpenSSH.Server~~~~0.0.1.0' | Out-Null
          }
        '';
    })

    #   (lib.mkIf (cfg.startupType == "automatic") {
    #     winpkgs.activation.installOpenSSHServer.command =
    #     # powershell
    #     ''
    #       Set-Service -Name sshd -StartupType Automatic
    #       Start-Service -Name sshd
    #     '';
    #   })

    #   (lib.mkIf (cfg.startupType == "manual") {
    #     winpkgs.activation.installOpenSSHServer.command =
    #     # powershell
    #     ''
    #       Set-Service -Name sshd -StartupType Disabled
    #     '';
    #   })

    #   (lib.mkIf (cfg.startupType == "disabled") {
    #     winpkgs.activation.installOpenSSHServer.command =
    #     # powershell
    #     ''
    #       Set-Service -Name sshd -StartupType Disabled
    #       Stop-Service -Name sshd -Force -ErrorAction SilentlyContinue
    #     '';
    #   })
  ];
}
