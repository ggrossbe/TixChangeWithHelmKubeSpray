FROM ceosimage:4.21.0F

MAINTAINER Srikant Noorani


ENV INTFTYPE=eth
ENV ETBA=1
ENV SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1
ENV CEOS=1
ENV EOS_PLATFORM=ceoslab
ENV container=docker

CMD ["/sbin/init", "systemd.setenv=INTFTYPE=eth systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker"]

