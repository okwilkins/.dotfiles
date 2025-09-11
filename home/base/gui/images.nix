let
  wallpaper = builtins.fetchurl {
    url = "https://drive.usercontent.google.com/download?id=1I077w8ePhbzfd2wWz-ZsL7TBpWkxk9E_\&export=download\&authuser=0";
    name = "leaf-wallpaper.jpg";
    sha256 = "sha256:1xmxf12q34rl3asj3y0kifh4icx4vp414rf08jra8xf5yc7m3z04";
  };
  profileHeadshot = builtins.fetchurl {
    url = "https://drive.usercontent.google.com/download?id=1TlNca10Kw-_0Ratfc-b1zbPr94VtXV-C&export=download&authuser=0";
    name = "headshot-profile.jpg";
    sha256 = "sha256:0yah2i74p5j8xknv8fnxq2agidp65pv3653qrzvcmkrjw3gzfkkq";
  };
in
{
  home.file."Pictures/wallpapers/leaf.jpg" = {
    source = wallpaper;
  };
  home.file."Pictures/profiles/headshot-profile.jpg" = {
    source = profileHeadshot;
  };
}
