.\" This is -*-nroff-*-
.\" XXX standard disclaimer belongs here....
.\" $Header: /usr/local/cvsroot/postgres95-support/doc/man/grant.l,v 1.1.1.1 1996/08/18 22:14:24 scrappy Exp $
.TH GRANT SQL 11/05/95 Postgres95 Postgres95
.SH NAME
grant \(em grant access control to a user or group
.SH SYNOPSIS
.nf
\fBgrant\fR <privilege[,privilege,...]>
	\fBon\fR <rel1>[,...<reln>]
	\fBto\fR [\fBpublic\fR | group <group> | <username>]

	\fBprivilege\fR is {\fBALL\fR | \fBSELECT\fR | \fBINSERT\fR | \fBUPDATE\fR | \fBDELETE\fR | \fBRULE\fR}
.fi
.SH DESCRIPTION
.PP
.B Grant
allows you to give specified permissions to all users or
a certain user or group.
By default, a table grants read-only (\fBSELECT\fR) to all Postgres users.
You must specifically revoke this privilege if this is not desired.
.SH EXAMPLES
.nf
--
--Example of a grant
--
grant insert
	on mytab
	to public
.fi
.SH "SEE ALSO"
revoke(l)

