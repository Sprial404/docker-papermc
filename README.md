# PaperMC Docker Image

This is a Docker image for [PaperMC](https://papermc.io/), a high performance fork of [Spigot](https://www.spigotmc.org/) running on [Amazon Corretto](https://aws.amazon.com/corretto/).

Bit of a learning project for me, so please feel free to open an issue if you have any suggestions or problems. I will try to respond as soon as I can but I am only one person so please be patient. :)

## Image Structure

The image is based on the [Alpine Linux](https://alpinelinux.org/) distribution. The following directories are used:
 - `/data` - The directory where the server files are stored. This is the directory that should be mounted to the host.
 - `/opt/papermc` - The directory where the PaperMC launcher and shell scripts are stored.

## Disclaimer

This image is not affiliated with PaperMC or Spigot. The image is provided as-is and without any warranty.

## License

The Unlicense (Public Domain) - see [LICENSE](LICENSE) for more information.