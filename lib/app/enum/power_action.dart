enum PowerAction {
  reboot(language: 'reboot', mode: ''),
  poweroff(language: 'power_off', mode: ''),
  rebootToFastboot(language: 'reboot_to_fastboot', mode: 'bootloader'),
  rebootToFastbootd(language: 'reboot_to_fastbootd', mode: 'fastboot'),
  rebootToRecovery(language: 'reboot_to_recovery', mode: 'recovery');

  const PowerAction({required this.language, required this.mode});

  final String language;
  final String mode;
}
