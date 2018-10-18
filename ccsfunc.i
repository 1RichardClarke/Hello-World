//		CCSFunc.i
//
//		Copyright (c) 1999-2000 Cornhill Computer Systems Limited


FUNCTION PadString$(tcInString$, tnLength)
	lnInStrLen = LEN(tcInString$)
	lnSpaces = tnLength - lnInStrLen
	lnCounter = 0

	WHILE lnCounter < lnSpaces
		xf_strcat(tcInString$, " ", tcInString$)

		lnCounter = lnCounter + 1
	END

	PadString$ = tcInString$
END


FUNCTION PrepTx$(tcInString$)
	lcReturn$ = ""

	tcInString$ = Alltrim$(tcInString$)

	xf_strcat(tcInString$, gcSeparator$, lcReturn$)

	PrepTx$ = lcReturn$
END


FUNCTION GetField$(tnFieldNo, tcInString$)
	lnErr = 0
	lcField$ = ""
	lcString$ = tcInString$
	lnCounter = 0
	lnCharsReturned = 0

	WHILE lnCounter < tnFieldNo
		lnCharsReturned = 0
		xf_textsearch(lnErr, lcString$, gcSeparator$, lnCharsReturned)

		IF lnCharsReturned > 1
			xf_strnpart(lnErr, lcString$, 1, BIN(lnCharsReturned - 1), lcField$)
		ELSE
			lcField$ = ""
		END

		xf_strnpart(lnErr, lcString$, BIN(lnCharsReturned + 1), BIN(LEN(lcString$) - lnCharsReturned), lcString$)

		lnCounter = lnCounter + 1
	END

	GetField$ = lcField$
END


FUNCTION GetFields(tcInString$)
	lnErr = 0
	lcField$ = ""
	lcString$ = tcInString$
	lcArrayChar$ = " "
	
	lnCounter = 0
	WHILE lnCounter < 20
		xf_arrayput(lnErr, gaFields$, lnCounter, lcArrayChar$)
		lnCounter = lnCounter + 1
	END
				
	lnCounter = 0
	lnCharsReturned = 0

	WHILE lnCounter < 20
		lnCharsReturned = 0
		xf_textsearch(lnErr, lcString$, gcSeparator$, lnCharsReturned)

		IF lnCharsReturned > 1
			xf_strnpart(lnErr, lcString$, 1, BIN(lnCharsReturned - 1), lcField$)
		ELSE
			lcField$ = " "
		END

		xf_arrayput(lnErr, gaFields$, lnCounter, lcField$)

		IF LEN(lcString$) > 0
			xf_strnpart(lnErr, lcString$, BIN(lnCharsReturned + 1), BIN(LEN(lcString$) - lnCharsReturned), lcString$)
	
			IF lnErr <> 0
				lnCounter = 21
			END
	
		END

		lnCounter = lnCounter + 1

	END
END

FUNCTION ATC(tcSearch$, tcSearched$, tnOccurence)
	lnErr = 0
	lnStrLen = LEN(tcSearched$)
	lcThisChar$ = ""
	lnCounter = 1
	lnOccurence = 0
	llComplete = FALSE
	lnReturn = 0

	IF tnOccurence < 1
		tnOccurence = 1
	END

	IF lnStrLen > 0
		xf_strnpart(lnErr, tcSearched$, BIN(lnCounter), 1, lcThisChar$)

		WHILE llComplete = FALSE
			lnCounter = lnCounter + 1

			IF lnCounter <= lnStrLen
				xf_strnpart(lnErr, tcSearched$, BIN(lnCounter), 1, lcThisChar$)

				IF lcThisChar$ = tcSearch$
					lnOccurence = lnOccurence + 1

					IF lnOccurence = tnOccurence
						llComplete = TRUE

						lnReturn = lnCounter
					END
				END
			ELSE
				llComplete = TRUE

				lnReturn = 0
			END
		END
	END

	ATC = lnReturn
END

FUNCTION Alltrim$(tcInString$)
	lnErr = 0
	lcThisChar$ = ""
	lnInStrLen = LEN(tcInString$)

	IF lnInStrLen > 0
		xf_strnpart(lnErr, tcInString$, 1, 1, lcThisChar$)
	END

	WHILE lcThisChar$ = CHR$(32) AND lnInStrLen > 0
		IF lnInStrLen >= 2
			xf_strnpart(lnErr, tcInString$, 2, BIN(lnInStrLen - 1), tcInString$)
		ELSE
			IF lcThisChar$ = CHR$(32)
				tcInString$ = ""
			END
		END

		xf_strnpart(lnErr, tcInString$, 1, 1, lcThisChar$)
		lnInStrLen = LEN(tcInString$)
	END

	IF lnInStrLen > 0
		xf_strnpart(lnErr, tcInString$, BIN(lnInStrLen), 1, lcThisChar$)
	ELSE
		lcThisChar$ = " "
	END

	WHILE lcThisChar$ = CHR$(32) AND lnInStrLen > 0
		xf_strnpart(lnErr, tcInString$, 1, BIN(lnInStrLen - 1), tcInString$)

		lnInStrLen = LEN(tcInString$)
		xf_strnpart(lnErr, tcInString$, BIN(lnInStrLen), 1, lcThisChar$)
	END

	Alltrim$ = tcInString$
END

