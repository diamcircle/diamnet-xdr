// Copyright 2022 Diamnet Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

// This is for 'internal'-only messages that are not meant to be read/written
// by any other binaries besides a single Core instance.
%#include "xdr/Diamnet-ledger.h"
%#include "xdr/Diamnet-SCP.h"

namespace diamnet
{
union StoredTransactionSet switch (int v)
{
case 0:
	TransactionSet txSet;
case 1:
	GeneralizedTransactionSet generalizedTxSet;
};

struct StoredDebugTransactionSet
{
	StoredTransactionSet txSet;
	uint32 ledgerSeq;
	DiamnetValue scpValue;
};

struct PersistedSCPStateV0
{
	SCPEnvelope scpEnvelopes<>;
	SCPQuorumSet quorumSets<>;
	StoredTransactionSet txSets<>;
};

struct PersistedSCPStateV1
{
	// Tx sets are saved separately
	SCPEnvelope scpEnvelopes<>;
	SCPQuorumSet quorumSets<>;
};

union PersistedSCPState switch (int v)
{
case 0:
	PersistedSCPStateV0 v0;
case 1:
	PersistedSCPStateV1 v1;
};
}