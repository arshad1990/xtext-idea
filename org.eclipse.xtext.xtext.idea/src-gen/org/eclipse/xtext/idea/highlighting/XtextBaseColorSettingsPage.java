/*
 * generated by Xtext 2.11
 */
package org.eclipse.xtext.idea.highlighting;

import org.eclipse.xtext.idea.lang.XtextLanguage;

public class XtextBaseColorSettingsPage extends AbstractColorSettingsPage {
	
	public XtextBaseColorSettingsPage() {
		XtextLanguage.INSTANCE.injectMembers(this);
	}

	@Override
	public String getDisplayName() {
		return XtextLanguage.INSTANCE.getDisplayName();
	}
}
