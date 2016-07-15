/*******************************************************************************
 * Copyright (c) 2015 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
grammar PsiInternalRefactoringTestLanguage;

options {
	superClass=AbstractPsiAntlrParser;
}

@lexer::header {
package org.eclipse.xtext.idea.common.types.idea.parser.antlr.internal;

// Hack: Use our own Lexer superclass by means of import. 
// Currently there is no other way to specify the superclass for the lexer.
import org.eclipse.xtext.parser.antlr.Lexer;
}

@parser::header {
package org.eclipse.xtext.idea.common.types.idea.parser.antlr.internal;

import org.eclipse.xtext.idea.parser.AbstractPsiAntlrParser;
import org.eclipse.xtext.idea.common.types.idea.lang.RefactoringTestLanguageElementTypeProvider;
import org.eclipse.xtext.idea.parser.TokenTypeProvider;
import org.eclipse.xtext.parser.antlr.XtextTokenStream;
import org.eclipse.xtext.parser.antlr.XtextTokenStream.HiddenTokens;
import org.eclipse.xtext.idea.common.types.services.RefactoringTestLanguageGrammarAccess;

import com.intellij.lang.PsiBuilder;
}

@parser::members {

	protected RefactoringTestLanguageGrammarAccess grammarAccess;

	protected RefactoringTestLanguageElementTypeProvider elementTypeProvider;

	public PsiInternalRefactoringTestLanguageParser(PsiBuilder builder, TokenStream input, RefactoringTestLanguageElementTypeProvider elementTypeProvider, RefactoringTestLanguageGrammarAccess grammarAccess) {
		this(input);
		setPsiBuilder(builder);
		this.grammarAccess = grammarAccess;
		this.elementTypeProvider = elementTypeProvider;
	}

	@Override
	protected String getFirstRuleName() {
		return "Model";
	}

}

//Entry rule entryRuleModel
entryRuleModel returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getModelElementType()); }
	iv_ruleModel=ruleModel
	{ $current=$iv_ruleModel.current; }
	EOF;

// Rule Model
ruleModel returns [Boolean current=false]
:
	(
		(
			{
				markComposite(elementTypeProvider.getModel_ReferenceHolderReferenceHolderParserRuleCall_0ElementType());
			}
			lv_referenceHolder_0_0=ruleReferenceHolder
			{
				doneComposite();
				if(!$current) {
					associateWithSemanticElement();
					$current = true;
				}
			}
		)
	)*
;

//Entry rule entryRuleReferenceHolder
entryRuleReferenceHolder returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getReferenceHolderElementType()); }
	iv_ruleReferenceHolder=ruleReferenceHolder
	{ $current=$iv_ruleReferenceHolder.current; }
	EOF;

// Rule ReferenceHolder
ruleReferenceHolder returns [Boolean current=false]
:
	(
		(
			(
				{
					markLeaf(elementTypeProvider.getReferenceHolder_NameIDTerminalRuleCall_0_0ElementType());
				}
				lv_name_0_0=RULE_ID
				{
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
				{
					doneLeaf(lv_name_0_0);
				}
			)
		)
		(
			(
				{
					if (!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
				{
					markComposite(elementTypeProvider.getReferenceHolder_DefaultReferenceJvmTypeCrossReference_1_0ElementType());
				}
				ruleFQN
				{
					doneComposite();
				}
			)
		)
	)
;

//Entry rule entryRuleFQN
entryRuleFQN returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getFQNElementType()); }
	iv_ruleFQN=ruleFQN
	{ $current=$iv_ruleFQN.current; }
	EOF;

// Rule FQN
ruleFQN returns [Boolean current=false]
:
	(
		{
			markLeaf(elementTypeProvider.getFQN_IDTerminalRuleCall_0ElementType());
		}
		this_ID_0=RULE_ID
		{
			doneLeaf(this_ID_0);
		}
		(
			{
				markLeaf(elementTypeProvider.getFQN_FullStopKeyword_1_0ElementType());
			}
			kw='.'
			{
				doneLeaf(kw);
			}
			{
				markLeaf(elementTypeProvider.getFQN_IDTerminalRuleCall_1_1ElementType());
			}
			this_ID_2=RULE_ID
			{
				doneLeaf(this_ID_2);
			}
		)*
		(
			{
				markLeaf(elementTypeProvider.getFQN_DollarSignKeyword_2_0ElementType());
			}
			kw='$'
			{
				doneLeaf(kw);
			}
			{
				markLeaf(elementTypeProvider.getFQN_IDTerminalRuleCall_2_1ElementType());
			}
			this_ID_4=RULE_ID
			{
				doneLeaf(this_ID_4);
			}
		)*
	)
;

RULE_ID : '^'? ('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'_'|'0'..'9')*;

RULE_INT : ('0'..'9')+;

RULE_STRING : ('"' ('\\' .|~(('\\'|'"')))* '"'|'\'' ('\\' .|~(('\\'|'\'')))* '\'');

RULE_ML_COMMENT : '/*' ( options {greedy=false;} : . )*'*/';

RULE_SL_COMMENT : '//' ~(('\n'|'\r'))* ('\r'? '\n')?;

RULE_WS : (' '|'\t'|'\r'|'\n')+;

RULE_ANY_OTHER : .;
