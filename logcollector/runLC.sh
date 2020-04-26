#docker run -v /Users/noosr03/Documents/CA_Technical/2_ProjectRepo/TixChangeWithHelmKubeSpray/logCollector:/logcollector_config -v /Users/noosr03/Documents/CA_Technical/2_ProjectRepo/TixChangeWithHelmKubeSpray/logCollector/logs:/opt/caemm/logs -p 6514:6514 -it --rm bc548d7cabbc bash

#docker run -v /Users/noosr03/Documents/CA_Technical/2_ProjectRepo/TixChangeWithHelmKubeSpray/logCollector/logcollector_cg:/logcollector_config -v /Users/noosr03/Documents/CA_Technical/2_ProjectRepo/TixChangeWithHelmKubeSpray/logCollector/logs:/opt/caemm/logs -it --rm -p 6514:6514 -it  bc548d7cabbc

#docker run -v /Users/noosr03/Documents/CA_Technical/2_ProjectRepo/TixChangeWithHelmKubeSpray/logCollector/logcollector_config:/logcollector_config -v /Users/noosr03/Documents/CA_Technical/2_ProjectRepo/TixChangeWithHelmKubeSpray/logCollector/logs:/opt/caemm/logs -it --rm -p 6514:6514 -it  bc548d7cabbc

#docker run -v /Users/noosr03/Documents/CA_Technical/2_ProjectRepo/TixChangeWithHelmKubeSpray/logCollector:/logcollector_config -v /Users/noosr03/Documents/CA_Technical/2_ProjectRepo/TixChangeWithHelmKubeSpray/logCollector/logs:/opt/caemm/logs -p 6514:6514 -it --rm bc548d7cabbc bash

#docker run -v /Users/noosr03/Documents/CA_Technical/2_ProjectRepo/TixChangeWithHelmKubeSpray/logCollector/logcollector_cg:/logcollector_config -v /Users/noosr03/Documents/CA_Technical/2_ProjectRepo/TixChangeWithHelmKubeSpray/logCollector/logs:/opt/caemm/logs -it --rm -p 6514:6514 -it  bc548d7cabbc


docker run --network=host -v /root/TixChangeWithHelmKubeSpray/logcollector/logcollector_config:/logcollector_config -v /root/TixChangeWithHelmKubeSpray/logcollector/logcollector_logs:/opt/caemm/logs -it --rm -p 0.0.0.0:6514:6514/tcp -it  -e LS_JAVA_OPTS="-Dls.log.level=trace" bc548d7cabbc
