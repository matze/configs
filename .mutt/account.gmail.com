# vim: set ft=muttrc

set from                = 'matthias.vogelgesang@gmail.com'
set spoolfile           = '+gmail/INBOX'
set record              = '=gmail/Sent'
set postponed           = '=gmail/Drafts'
set trash               = '=gmail/Trash'
set mbox                = '=gmail/Archives'
set signature           = '~/.mutt/signature.gmail.com'

set pgp_use_gpg_agent   = yes
set pgp_sign_as         = 4D3A8106

folder-hook $folder/gmail       "macro index,pager $ '<sync-mailbox><shell-escape>mbsync gmail.com<enter><sync-mailbox>'"

mailboxes +gmail \
          +gmail/INBOX \
          =gmail/Sent \
          =gmail/Drafts \
          =gmail/ranger-users

subscribe ranger-users@nongnu.org
