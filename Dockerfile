FROM continuumio/miniconda3

# Utils
RUN apt-get -y update
RUN apt-get -y install wget curl vim net-tools

# Python and Dependencies
RUN conda update -n base -c defaults conda
RUN conda create -n env python=3.6
RUN conda install --yes -c anaconda jupyter pandas numpy scikit-learn statsmodels seaborn gensim nltk joblib tensorflow
RUN conda install --yes -c conda-forge matplotlib holoviews imbalanced-learn wordcloud mlxtend folium pyldavis rise
RUN conda install --yes -c bokeh bokeh

RUN echo "source activate env" > ~/.bashrc
ENV PATH /opt/conda/envs/env/bin:$PATH
RUN jupyter-nbextension install rise --py --sys-prefix
