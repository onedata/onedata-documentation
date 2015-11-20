.. _onedata_concpets:


***************
Onedata Concepts
***************


Input for glossary:
=============================

* **a Space**, any space owen by some user
* **storage space**, that which Provider, provides to the user
* **a token**, some string of character that can be used to link a *storage space* provider by a *Provider*

Summary: This document explains key concept behind Onedata: Spaces, how they relate to Providers and how they can be shared among users.

What is a Space?
=================
Space is a virtual directory that can store data, be shared with other users, or published as a public directory. Each user can create multiple Spaces.

Increasing size
===============
At the beginning a Space has 0MB size, since none physical storage has yet been attached to it. In order to be able to store data in a Space, it has to get a support of a Provider. User requests storage space from a Provider and in turn receives a token. The token is then entered in Space's settings and links users's Space with a storage space supplied by a Provider. A Space can be supported by multiple Providers.

Space sharing
==============
A Space can be shared with a user, group or set to be public. You can choose how visible your Space will be to others, and what others can do with your Space.


The visibility levels:

+----------------------+---------------------------------------------------------------------------+-------------------------------+
| Visibility           | Definition                                                                |  Sign-in to Onedata Required? |
+======================+===========================================================================+===============================+
| Specyfic Users       | ...                                                                       | Yes                           |
+----------------------+---------------------------------------------------------------------------+-------------------------------+
| Anyone with the link | Anyone who is given the link to your Space can access it                  | No                            |
+----------------------+---------------------------------------------------------------------------+-------------------------------+
| Public on the web    | Anyone can access the Space on the Interent through search of web address | No                            |
+----------------------+---------------------------------------------------------------------------+-------------------------------+

Onedata is a distributed data access system that allows users to


Spaces and data sharing

File and Directory sharing
==============
