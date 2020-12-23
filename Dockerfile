FROM continuumio/miniconda3

# Utils
RUN apt-get -y update
RUN apt-get -y install wget curl vim net-tools

# Install Java
RUN wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz -P /usr/local/.
RUN tar -xzvf /usr/local/jdk-8u131-linux-x64.tar.gz -C /usr/local/
RUN ln -s /usr/local/jdk1.8.0_131/ /usr/local/java
ENV JAVA_HOME "/usr/local/java"
ENV PATH "$JAVA_HOME/bin:$PATH"

# Python and Dependencies
RUN conda update -n base -c defaults conda
RUN conda create -n env python=3.8
RUN conda install --yes -c anaconda jupyter pandas numpy scikit-learn statsmodels seaborn nltk joblib tensorflow
RUN conda install --yes -c conda-forge matplotlib holoviews imbalanced-learn wordcloud mlxtend folium pyldavis jupyterthemes scrapy pyspark rise
RUN conda install --yes -c gurobi gurobi
RUN conda install --yes -c bokeh bokeh

RUN echo "source activate env" > ~/.bashrc
ENV PATH /opt/conda/bin:$PATH
RUN jupyter-nbextension install rise --py --sys-prefix
RUN jt -t grade3
