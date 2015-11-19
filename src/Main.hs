module Main where
import           Data.IP
import           Network.BSD
import qualified Network.Info            as NI
import           Network.Socket.Internal
main::IO()
main = do
    ns <- NI.getNetworkInterfaces
    putStrLn "Network Interfaces"
    putStrLn "------------------"
    mapM_ (putStr . showInterface) ns

    putStrLn "------------------"
    hostname <- getHostName
    putStrLn $ "HostName:  " ++  hostname
    putStrLn "------------------"
    putStrLn "Host Entries"
    putStrLn "------------------"
    hostentries <- getHostEntries False
    mapM_ (putStr.showHostEntry) hostentries


showInterface::NI.NetworkInterface-> String
showInterface n = NI.name n ++ "\n"
               ++ "  IPv4: " ++ show (NI.ipv4 n) ++ "\n"
               ++ "  IPv6: " ++ show (NI.ipv6 n) ++ "\n"
               ++ "  MAC:  " ++ show (NI.mac n) ++ "\n"

showHostEntry::HostEntry -> String
showHostEntry he =  show  (hostName he) ++ "\n"
                   ++ "  Aliases:      " ++ show (hostAliases he) ++ "\n"
                   ++ "  Family:       " ++ show (hostFamily he) ++ "\n"
                   ++ "  Host Address: " ++ show  (map formatHostAddresses (hostAddresses he)) ++ "\n"
   where formatHostAddresses h' =
            case hostFamily he of
              AF_INET6 -> show h'
              _        -> show (fromHostAddress h')
