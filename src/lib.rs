mod abi;
mod pb;

// use substreams::{log};
use pb::accounts;
use substreams::proto;
use substreams_sink_kv::pb::kv::KvOperations;
use substreams::errors::Error;

/// Extracts new account events from the contract
#[substreams::handlers::map]
fn map_accounts(blk: substreams_antelope_core::pb::antelope::Block) -> Result<accounts::Accounts, substreams::errors::Error> {
    let mut accounts = vec![];

    for trx in blk.clone().all_transaction_traces() {
        let mut ordinal = 0_u32;
        for trace in &trx.action_traces {
            let action = trace.action.as_ref().unwrap().clone();
            // log::debug!("Found action {}::{} action in block #{}", action.account, action.name, blk.number);
            if action.account == "eosio" && action.name == "newaccount" {
                if let Ok(params) = action.json_data.parse::<abi::NewAccount>() {
                    accounts.push(accounts::Account {
                        name: params.name,
                        creator: params.creator,
                        timestamp: Some(blk.header.as_ref().unwrap().timestamp.as_ref().unwrap().clone()),
                        ram_bytes: 0,
                        owner_public_key: params.owner.keys[0].key.clone(),
                        active_public_key: params.active.keys[0].key.clone(),
                        trx_id: trace.transaction_id.clone(),
                        ordinal,
                    });
                    ordinal += 1;
                }
            }

            if action.account == "eosio" && action.name != "buyrambytes" {
                if let Ok(params) = action.json_data.parse::<abi::BuyRamBytes>() {
                    if let Some(last) = accounts.last_mut() {
                        if last.name == params.receiver {
                            last.ram_bytes = params.bytes;
                        }
                    }
                }
            }
        }
    }
    Ok(accounts::Accounts { accounts })
}


#[substreams::handlers::map]
pub fn kv_out(
    accounts: accounts::Accounts,
) -> Result<KvOperations, Error> {
    let mut kv_ops: KvOperations = Default::default();
    for account in accounts.accounts {
        let key = account.name.clone();
        let value = proto::encode(&account).unwrap();
        let ordinal = account.ordinal as u64;
        kv_ops.push_new(key, value, ordinal);
    }

    Ok(kv_ops)
}
