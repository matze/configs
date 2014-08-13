# vim: set ft=muttrc

set from                = 'matthias.vogelgesang@gmail.com'
set spoolfile           = '+gmail/INBOX'
set record              = '=gmail/[Gmail]/.Sent Mail'
set postponed           = '=gmail/[Gmail]/.Drafts'
set mbox                = '=gmail/[Gmail]/.All Mail'
set signature           = '~/.mutt/signature.gmail.com'

folder-hook $folder/gmail       "macro index,pager $ '<sync-mailbox><shell-escape>mbsync gmail.com<enter><sync-mailbox>'"
folder-hook $folder/gmail/INBOX "macro index,pager $ '<sync-mailbox><shell-escape>mbsync gmail.com:INBOX<enter><sync-mailbox>'"

mailboxes +gmail \
          +gmail/INBOX \
          =gmail/[Gmail]/'.Sent Mail' \
          =gmail/[Gmail]/'.Drafts'
