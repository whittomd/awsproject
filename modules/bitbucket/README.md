modules/dist/bitbucket-org
==========================

This is a puppet module that install the Bitbucket host key into the system
known hosts file (typically /etc/ssh/ssh_known_hosts).  Including the
bitbucket-org class from this module in a puppet node will allow git activity
on the node to proceed without ever having to answer whether to trust the host
key while maintaining secure authentication of the bitbucket server.
