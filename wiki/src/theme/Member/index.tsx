import React, { JSX } from "react";
import clsx from "clsx";
import { translate } from "@docusaurus/Translate";
import { useColorMode, useThemeConfig } from "@docusaurus/theme-common";
import Link from "@docusaurus/Link";
import useBrokenLinks from "@docusaurus/useBrokenLinks";
import BrowserOnly from "@docusaurus/BrowserOnly";
import type { Props } from "@theme/Heading";

import { toast, Zoom } from "react-toastify";

import IconCopy from "@theme/Icon/Copy";
import IconLink from "@theme/Icon/Link";

import styles from "./styles.module.css";

import { useLocation } from "react-router-dom";

export default function Heading({
  id,
  group,
  ...props
}: Props & {
  group: "method" | "function" | "property" | "configurable" | "event" | "group" | number;
}): JSX.Element {
  const brokenLinks = useBrokenLinks();
  const {
    navbar: { hideOnScroll },
  } = useThemeConfig();

  brokenLinks.collectAnchor(id);

  let HeaderSize: keyof JSX.IntrinsicElements;
  if (typeof group === "number" && group >= 1 && group <= 6) {
    HeaderSize = `h${group}` as keyof JSX.IntrinsicElements;
  } else if (group === "group") {
    HeaderSize = "h2";
  } else {
    HeaderSize = "h3";
  }

  const anchorTitle = translate(
    {
      id: "theme.common.headingLinkTitle",
      message: "Direct link to {heading}",
      description: "Title for link to heading",
    },
    {
      heading: id,
    }
  );

  const markdownLinkTitle = translate(
    {
      id: "theme.common.markdownLinkTitle",
      message: "Copy markdown link to {heading}",
      description: "Markdown for link to heading",
    },
    {
      heading: id,
    }
  );

  const pathName = useLocation().pathname;

  return (
    <HeaderSize
      {...props}
      className={clsx(
        "anchor",
        hideOnScroll
          ? styles.anchorWithHideOnScrollNavbar
          : styles.anchorWithStickyNavbar,
        props.className
      )}
      id={id}
    >
      {props.children}
      <Link
        className="icon-link"
        to={`#${id}`}
        aria-label={anchorTitle}
        title={anchorTitle}
      >
        <IconLink width="0.75em" height="0.75em" />
      </Link>
      <BrowserOnly>
        {() => {
            const pathSegments = location.pathname.split("/").filter(Boolean);
            const pageName = pathSegments[pathSegments.length - 1];

            const displayString =
            group == "group"
              ? `\`${pageName}\`'s ${id.toLowerCase()}`
              : group == "function"
              ? `\`${pageName}.${id}()\``
              : group == "method"
              ? `\`${pageName}:${id}()\``
              : `\`${pageName}.${id}\``;
            const linkString = `${window.location.origin}${encodeURI(pathName)}#${encodeURIComponent(id)}`;
            const markdownLink = `[${displayString}](<${linkString}>)`;

          return (
            <a
              className="icon-link"
              aria-label={markdownLinkTitle}
              title={markdownLinkTitle}
              onClick={() => {
                toast.dark(
                  <a>
                    Copied the <code>{id}</code> link to clipboard.
                  </a>,
                  {
                    position: "top-center",
                    autoClose: 1000,
                    hideProgressBar: true,
                    closeOnClick: true,
                    pauseOnHover: true,
                    draggable: false,
                    progress: undefined,
                    theme: "colored",
                    transition: Zoom,
                  }
                );
                navigator.clipboard.writeText(markdownLink);
              }}
            >
              <IconCopy width="0.75em" height="0.75em" />
            </a>
          );
        }}
      </BrowserOnly>
    </HeaderSize>
  );
}
