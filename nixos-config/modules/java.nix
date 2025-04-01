{ config, pkgs, ... }:

# AI-Generated

{
  # =============================================
  # Java & Kotlin Development Environment
  # =============================================

  programs.java = {
    enable = true;
    package = pkgs.jetbrains.jdk;
  };

  environment.systemPackages = with pkgs; [
    # ===== JDK =====
    jdk21  # Primary JDK (OpenJDK 21)
    
    # graalvm-ce  # For native-image compilation
    # amazon-corretto-21  # AWS-optimized JDK
    # adoptopenjdk-jdk-bin-21  # Alternative build

    # ===== Kotlin Toolchain =====
    kotlin  # Kotlin compiler
    ktlint  # Kotlin linter
    kotlin-language-server  # LSP server
    
    # ===== Build Tools =====
    gradle  # Modern build system
    maven  # Apache Maven
    sbt  # Scala build tool (optional)

    # ===== Dev Util =====
    jq  # JSON processor
    visualvm  # Monitoring/troubleshooting
    jetbrains.idea-community # IDE 
  ];
}
