import { bytesToBigInt, fromHex } from "@zk-email/helpers/dist/binary-format";
import { generateEmailVerifierInputs } from "@zk-email/helpers/dist/input-generators";


export type IBinanceCircuitInputs = {
  address: string;
  emailHeader: string[];
  emailHeaderLength: string;
  pubkey: string[];
  signature: string[];
};

export async function generateBinanceVerifierCircuitInputs(
  email: string | Buffer,
  ethereumAddress: string
): Promise<IBinanceCircuitInputs> {
  const emailVerifierInputs = await generateEmailVerifierInputs(email, {
    ignoreBodyHashCheck: true,
  });


  const address = bytesToBigInt(fromHex(ethereumAddress)).toString();

  return {
    ...emailVerifierInputs,
    address,
  };
}