module Main where
import Network.Info
import Network.BSD
import Network.Socket.Internal

main::IO()
main = do
    ns <- getNetworkInterfaces
    mapM_ (putStr . showInterface) ns
    hostname <- getHostName
    hostentry <- getHostEntries False
    putStrLn hostname   
    print hostentry 

showInterface::NetworkInterface-> String
showInterface n = name n ++ "\n"
               ++ "  IPv4: " ++ show (ipv4 n) ++ "\n"
               ++ "  IPv6: " ++ show (ipv6 n) ++ "\n"
               ++ "  MAC:  " ++ show (mac n) ++ "\n"
               
getLocalHostIP::IO HostAddress
getLocalHostIP = do
    hostEntries <- getHostEntries False
    return $ findLocalIP hostEntries

findLocalIP::[HostEntry]->HostAddress
findLocalIP =undefined

    