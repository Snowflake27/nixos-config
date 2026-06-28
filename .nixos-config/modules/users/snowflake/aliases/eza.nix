{ ... }:

let
	iconsFlag  = "--icons=always";
	colorsFlag = "--color=always";

	groupDirs  = "--group-directories-first";
	acrossFlag = "--across";

	levelsFlag = "--level=2";

	alwaysIncludeFlags = "${iconsFlag} ${colorsFlag}";
in
{
	ls = "eza    ${alwaysIncludeFlags} ${groupDirs} ${acrossFlag}";
	ll = "eza -l ${alwaysIncludeFlags} ${groupDirs} ${acrossFlag}";
	la = "eza -a ${alwaysIncludeFlags} ${groupDirs} ${acrossFlag}";

	lt  = "eza --tree    ${alwaysIncludeFlags} ${levelsFlag}";
	lta = "eza --tree -a ${alwaysIncludeFlags} ${levelsFlag}";
}