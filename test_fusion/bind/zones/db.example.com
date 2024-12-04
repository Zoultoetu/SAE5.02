$ttl 1H
exemple.com.          IN      SOA     ksxxxxx.kimsufi.com. email@example.com. (
                                        2011041902 ; Serial
                                        1H ; Refresh
                                        15M ; Retry
                                        2W ; Expire
                                        3M ; Minimum TTL
                                        )
exemple.com.  IN      NS              ksxxxxx.kimsufi.com.
exemple.com.  IN      NS              ns.kimsufi.com.
exemple.com.  IN      MX              10 mail.exemple.com.
exemple.com.  IN      A               111.222.111.222
mail          IN      A               111.222.111.222