{ pkgs, ... }:

{
    env.DEVSHELL_ENV = "Peldotter";

    packages = with pkgs; [
        love
    ];

}
