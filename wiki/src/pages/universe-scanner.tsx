import { useCallback, useEffect, useRef } from "react";
import Layout from "@theme/Layout";
import useBaseUrl from "@docusaurus/useBaseUrl";
import { useColorMode } from "@docusaurus/theme-common";

function Scanner() {
	const { colorMode } = useColorMode();
	const frame = useRef<HTMLIFrameElement>(null);
	const src = useBaseUrl("/universe-scanner-app.html");

	const sync = useCallback(() => {
		frame.current?.contentWindow?.postMessage(
			{ type: "colorMode", colorMode },
			window.location.origin,
		);
	}, [colorMode]);

	useEffect(sync, [sync]);

	return (
		<iframe
			ref={frame}
			src={src}
			title="Universe Scanner"
			onLoad={sync}
			style={{
				display: "block",
				border: 0,
				width: "100%",
				height: "calc(100vh - var(--ifm-navbar-height))",
			}}
		/>
	);
}

export default function UniverseScannerPage() {
	return (
		<Layout
			title="Universe Scanner"
			description="Search the Waste of Space universe for systems matching planet and resource queries."
			noFooter
		>
			<Scanner />
		</Layout>
	);
}
