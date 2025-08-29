let
  wallpaper = builtins.fetchurl {
    url = "https://drive.usercontent.google.com/download?id=1I077w8ePhbzfd2wWz-ZsL7TBpWkxk9E_\&export=download\&authuser=0";
    name = "leaf_wallpaper.jpg";
    sha256 = "sha256:1xmxf12q34rl3asj3y0kifh4icx4vp414rf08jra8xf5yc7m3z04";
  };
in
{
  home.file."Pictures/wallpapers/leaf.jpg" = {
    source = wallpaper;
  };
}
