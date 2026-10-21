FROM i.anatase.org/base:rolling

# Do your thing...
# Install btop
# RUN dnf -y install btop

# Install coolercontrol
# # For COPRs specify fedora-* as dnf will try to look for an anatase COPR
# RUN . /etc/os-release && \
#     dnf -y copr enable codifryed/CoolerControl "fedora-${VERSION_ID}-$(arch)" && \
#     dnf -y install coolercontrol && \
#     systemctl enable coolercontrold

RUN --mount=type=cache,target=/var/cache/dnf \
    --mount=type=cache,target=/var/lib/dnf \    
    . /etc/os-release && \
    dnf -y copr enable lionheartp/Hyprland "fedora-${VERSION_ID}-$(arch)" && \
    dnf -y --setopt=install_weak_deps=False install \
    	hyprcursor \
	hyprgraphics \
	hypridle \
	hyprland-qt-support \
	hyprqt6engine \
	hyprshot \
        hyprland-git \
	hyprland-guiutils \
	noctalia-git \
	noctalia-greeter-git \
	kitty \
	kwallet \
	pam \
	pam-kwallet \
	greetd \
	ksshaskpass \
	wl-clipboard \
	&& dnf clean all

COPY files/ /

RUN systemctl enable greetd.service && \
    systemctl set-default graphical.target

# Cleanup (leave this here)
RUN rm -rf /var && \
    mkdir -p /var/tmp
