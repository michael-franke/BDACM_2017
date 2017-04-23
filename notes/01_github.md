# Where is the course material?

The [course website](https://michael-franke.github.io/BDACM_2017/) and all course material is hosted on [GitHub](https://github.com) in a publicly accessible [repository](https://github.com/michael-franke/BDACM_2017).

# What is GitHub?

[GitHub](https://github.com) is a web-based hosting service for [version control](https://en.wikipedia.org/wiki/Repository_(version_control)), based on [Git](https://git-scm.com).

# How to get the material?

There are at least three ways to access and interact with the course material.

1. access the compiled slides and notes through the browser
2. download the whole [GitHub](https://github.com) [repository](https://github.com/michael-franke/BDACM_2017)
3. clone the repository and keep it updated with [GitHub](https://github.com)

## Online access

You can **access** slides and notes from the [course website](https://michael-franke.github.io/BDACM_2017/). 

## Download

If you want to obtain all files and code in the [repository](https://github.com/michael-franke/BDACM_2017), you can **download** a copy even without a GitHub account. In order to do so:

1. got to the [repository](https://github.com/michael-franke/BDACM_2017)
2. click on the green button with label "clone or download"
3. download the file as a zip

The downside of this approach is that you may have to download a new zipped copy of the complete material every time something is added or changed. (And: you never really know when anything has changed.) 

## Clone & update

You can use [Git](https://git-scm.com) to **clone** the whole GitHub repository. You then also get a local copy of the whole content. Additionally, you are able to **update** the content whenever anything has changed. 

To do this, you need to [install Git](https://git-scm.com/downloads) and possibly get a GitHub account (which is free). Basically, you will need only two operations: first, you clone the repository, then you update it repeatedly. There are a number of [graphical user interfaces](https://git-scm.com/downloads/guis) that make it easy to work with Git-controled repositories. If you want to work with Git from a command line, you need to do this:

Initially clone the repository with this command:

    git clone https://github.com/michael-franke/BDACM_2017.git

This creates a folder `BDACM_2017`. Inside this folder (no matter how deep), you can use this command to update:

    git pull
    
For this to work smoothly (without errors or interruptions), it is best to not change any of the downloaded files. If you want to experiment and make changes, best copy and rename the files before making changes.

# More about Git & GitHub

Of course, there is much more to version control. Please explore! You can learn about the use of Git from many resources, e.g., follow the [official documentation site](https://git-scm.com/doc). To learn more about GitHub, a good place to start are these [guides](https://guides.github.com).