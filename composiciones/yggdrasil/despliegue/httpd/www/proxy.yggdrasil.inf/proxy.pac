function FindProxyForURL(url, host) {
	if (dnsDomainIs(host, "netflix.com") ||
	    dnsDomainIs(host, "nflximg.net") ||
	    dnsDomainIs(host, "nflxext.com") ||
	    (host == "assets.nflxext.com") || 
	    (host == "ss.symcd.com"))
		return "DIRECT";

    if (dnsDomainIs(host, "sysonline.es") ||
        dnsDomainIs(host, "ovh.net"))
        return "DIRECT";

	if (dnsDomainIs(host, "roche.com") ||
	    dnsDomainIs(host, "roche.net") ||
	    dnsDomainIs(host, "leganesfarma.com"))
		return "DIRECT";

	if (dnsDomainIs(host, "yggdrasil.inf"))
		return "DIRECT";

	if (isPlainHostName(host) ||
	   shExpMatch(host, "*.local") ||
	   isInNet(dnsResolve(host), "10.0.0.0", "255.0.0.0") ||
	   isInNet(dnsResolve(host), "172.16.0.0",  "255.240.0.0") ||
	   isInNet(dnsResolve(host), "192.168.0.0",  "255.255.0.0") ||
	   isInNet(dnsResolve(host), "127.0.0.0", "255.255.255.0"))
		return "DIRECT";

	return "PROXY 192.168.1.151:3128";
}

