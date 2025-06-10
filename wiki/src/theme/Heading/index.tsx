import React, { JSX } from "react";
import clsx from "clsx";
import { translate } from "@docusaurus/Translate";
import { useThemeConfig } from "@docusaurus/theme-common";
import Link from "@docusaurus/Link";
import useBrokenLinks from "@docusaurus/useBrokenLinks";
import type { Props } from "@theme/Heading";

import styles from "./styles.module.css";

export default function Heading({ as: As, id, ...props }: Props): JSX.Element {
  const brokenLinks = useBrokenLinks();
  const {
    navbar: { hideOnScroll },
  } = useThemeConfig();

  if (As === "h1" || !id) {
    return <As {...props} id={undefined} />;
  }

  brokenLinks.collectAnchor(id);

  const anchorTitle = translate(
    {
      id: "theme.common.headingLinkTitle",
      message: "Direct link to {heading}",
      description: "Title for link to heading",
    },
    {
      heading: typeof props.children === "string" ? props.children : id,
    }
  );

  return (
    <As
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
        className="hash-link"
        to={`#${id}`}
        aria-label={anchorTitle}
        title={anchorTitle}
      >
        &#8203;
      </Link>
    </As>
  );
}
