let
  wallpaper = builtins.fetchurl {
    url = "https://drive.usercontent.google.com/download?id=1I077w8ePhbzfd2wWz-ZsL7TBpWkxk9E_\&export=download\&authuser=0";
    name = "leaf-wallpaper.jpg";
    sha256 = "sha256:1xmxf12q34rl3asj3y0kifh4icx4vp414rf08jra8xf5yc7m3z04";
  };
  profileHeadshot = builtins.fetchurl {
    url = "https://drive.usercontent.google.com/download?id=1XxqUGqaPZloubV_5cOlnUy7lxKiHEk7V&export=download&authuser=0";
    name = "headshot-profile.png";
    sha256 = "sha256:1lafzxg9q2xclxirwngaw75sbmdlpa6vhbiga8m8fkslb3hshgmc";
  };
in
{
  home.file."Pictures/wallpapers/leaf.jpg" = {
    source = wallpaper;
  };
  home.file."Pictures/profiles/headshot-profile.png" = {
    source = profileHeadshot;
  };
}
