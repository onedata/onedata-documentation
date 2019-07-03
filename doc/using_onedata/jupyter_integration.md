# Jupyter Notebook integration

<!-- toc -->

Onedata can be easily integrated with Jupyter Notebooks via the OnedataFS Python library
and OnedataFS-Jupyter plugin. The integration can involve 2 separate aspects:

* Storing the notebooks directly in Onedata data spaces
* Accessing Onedata spaces from within the notebooks

> This section explains the first of these aspects. The second aspect can be achieved
> by simply installing the [OnedataFS Python plugin](./onedatafs.md) on the Jupyter Notebook server.


OnedataFS-Jupyter plugin implements Jupyter
[Contents API](https://jupyter-notebook.readthedocs.io/en/stable/extending/contents.html),
making a Onedata space a default storage backend for the Jupyter notebooks for a particular
Jupyter instance.

## Installation

OnedataFS-Jupyter extension can be installed from our provided packages for both
Python 2 and Python 3, depending the Python version which is used to start the Jupter server.

### Ubuntu

```
wget https://get.onedata.org/oneclient.sh

# For Python2
pip install fs
sh oneclient.sh python-onedatafs-jupyter

# For Python3
pip3 install fs
sh oneclient.sh python3-onedatafs-jupyter
```

### CentOS

Please note that CentOS version, as all Onedata CentOS packages are distributed
according to the [Software Collections](https://www.softwarecollections.org/en/) standard.

```
wget https://get.onedata.org/oneclient.sh

# For Python2
pip install fs
sh oneclient.sh onedata1802-python2-onedatafs-jupyter
scl enable onedata1802 bash

# For Python3
pip3 install fs
sh oneclient.sh onedata1802-python3-onedatafs-jupyter
scl enable onedata1802 bash
```

## Usage

In order to configure Jupyter Notebook to work directly in a Onedata Space,
add the following lines to the Jupyter configuration file:

```python
import sys

c = get_config()

c.NotebookApp.contents_manager_class = 'onedatafs_jupyter.OnedataFSContentsManager'

# Hostname or IP of the Oneprovider to which the Jupyter should connect
c.OnedataFSContentsManager.oneprovider_host = u'datahub.egi.eu'

# The Onedata user access token
c.OnedataFSContentsManager.access_token = u'MDAzN2xvY2F00aW...'

# Name of the space, where the notebooks should be stored
c.OnedataFSContentsManager.space = u'/experiment-1'

# Internal path within a data space, for instance to a subdirectory where Jupyter 
# notebooks should be stored, must be relative (i.e. cannot start with `/`)
c.OnedataFSContentsManager.path = u''

# When True, allow connection to Oneprovider instances without trusted certificates
c.OnedataFSContentsManager.insecure = True

# When True, disables internal OnedataFS buffering, should be set to False for
# use cases handling larger files
c.OnedataFSContentsManager.no_buffer = True

# With these settings, all data transfers between Jupyter and Onedata will be performed
# in ProxyIO mode, without direct access to the backend storage. For testing
# and use cases with small files this is ok, but for high-performance calculation
# the following 2 lines should be negated
c.OnedataFSContentsManager.force_proxy_io = True
c.OnedataFSContentsManager.force_direct_io = False

# Set the log level
c.Application.log_level = 'DEBUG'

# The following line disables Jupyter authentication, for production deployments
# remove it or provide a custom token
c.NotebookApp.token = ''
```

When starting Jupyter using a Docker (assuming the container contains all necessary dependencies),
the configuration file can be easily mapped to the Jupyter using volume option, e.g.:

```
docker run -v $PWD/my_jupyter_notebook_config.py:/root/.jupyter/jupyter_notebook_config.py -it onedata/onedatafs-jupyter
```

If you don't have a config yet, create it using:

```bash
jupyter notebook --generate-config
```
