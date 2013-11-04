module Main where
import Network.Info

main::IO()
main = do
    ns <- getNetworkInterfaces
    mapM_ (putStr . showInterface) ns

showInterface::NetworkInterface-> String
showInterface n = name n ++ "\n"
               ++ "  IPv4: " ++ show (ipv4 n) ++ "\n"
               ++ "  IPv6: " ++ show (ipv6 n) ++ "\n"
               ++ "  MAC:  " ++ show (mac n) ++ "\n"